  class AgileData

  def initialize(dataProvider)
    @dataProvider = dataProvider
  end

  def save
    @model_grid.each do |board|
      board.save()
    end
  end

  def update
    @boards = @dataProvider.get_boards
    updateModelGrid
    createSprints
    get_sprint_changes
    processAllChanges
  end

  def create

    @boards = @dataProvider.get_boards
    @sprintChanges = @dataProvider.sprint_changes_for(@boards)

  end

  def process_data

      # cube
      @cube = {}
      @cube['boards'] = Hash.new()
      @cube['assignees'] = Hash.new()
      @cube['sprints'] = Hash.new()

      boards = Board.includes(:stories, :sprints => [:sprint_stories, :changes])
      boards.each &method(:process_board)

  end


  def process_board(board)
      board.sprints.each &method(:process_sprint)
  end

  def process_sprint(sprint)

      sprint.init_commitment = 0
      sprint.added_commitment = 0
      sprint.estimate_changed = 0
      sprint.total_commitment = 0

      sprint.init_velocity = 0
      sprint.added_velocity = 0
      sprint.estimate_changed_velocity = 0
      sprint.total_velocity = 0


      sprint.missed_added_commitment = 0
      sprint.missed_init_commitment  = 0
      sprint.missed_estimate_changed = 0
      sprint.missed_total_commitment = 0

      sprint.sprint_stories.each { |sstory|

        sprint.init_commitment += sstory.init_size unless sstory.was_added
        sprint.added_commitment += sstory.size if sstory.was_added
        sprint.estimate_changed += sstory.size - sstory.init_size
        sprint.total_commitment += sstory.size


        if sstory.is_done && sstory.assignee

          sprint.init_velocity += (sstory.init_size || 0) unless sstory.was_added
          sprint.added_velocity += (sstory.size || 0) if sstory.was_added
          sprint.estimate_changed_velocity += sstory.size - sstory.init_size if sstory.size - sstory.init_size != 0
          sprint.total_velocity += (sstory.size || 0)

          wa = WorkActivity.find_by_assignee_id_and_sprint_id(sstory.assignee.id, sprint.id)

          unless wa
            wa = WorkActivity.new()
            wa.story_points = 0
            wa.task_hours = 0
            wa.assignee = sstory.assignee
            wa.board = sprint.board
            wa.sprint = sprint
            wa.pid = sprint.board.pid + '_' + sprint.pid + '_' + sstory.assignee.pid
          end

          wa.story_points += sstory.size
          wa.save()
        end

        sprint.missed_added_commitment = sprint.added_commitment - sprint.added_velocity
        sprint.missed_init_commitment = sprint.init_commitment - sprint.init_velocity
        sprint.missed_estimate_changed = sprint.estimate_changed - sprint.estimate_changed_velocity
        sprint.missed_total_commitment = sprint.total_commitment - sprint.total_velocity

        sstory.save()
      }
      sprint.save()

  end


end
