class EventsController < ApplicationController
    def create_event
      params = JSON.parse(request.body.read)
      event_create
    end
  
    def get_events_by_issue
      if is_numeric(params[:issue_number]) && issue_number(params[:issue_number])
        events = select_event
          
        render json: events
      else
        render_error('Issue not found or value different to number')
      end
    end
  
    private

        def is_numeric(value)
            true if Float(value) rescue false
        end
    
        def issue_number(string)
            Event.where('number = ?', params[:issue_number]).any?
        end

        def select_event
            Event.select(:action, :created_at)
                .where('number = ?', params[:issue_number])
                .order('created_at desc')
                .as_json(:except => :id)
        end

        def render_error(errors)
            render json: { errors: errors }, status: :unprocessable_entity
        end

        def event_create
            Event.create(
                :action => params[:action],
                :number => params[:issue][:number]
            )
        end
end