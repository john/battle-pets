namespace :battle do

  # bundle exec rake battle:start --trace
  desc "Start a simulated battle"
  task start: :environment do
    # Create a user
    # POST: http://localhost:3000/api/v1/users
    # Headers: Content-Type application/json, Accept application/json
    # {
    #   "user": {
    #     "name": "bob3",
    #     "email": "bob3@test.com",
    #     "password": "latte4me"
    #   }
    # }

    # Get an auth token for that user
    # POST: http://localhost:3000/api/v1/users/sign_in
    # Headers: Content-Type application/json, Accept application/json
    # {
    #   "user": {
    #     "name": "bob3",
    #     "email": "bob3@test.com",
    #     "password": "latte4me"
    #   }
    # }

    # Record auth token returned. Put in session?

    # Create a Contest
    # POST /api/v1/contest

    # Create a pet for that contest:
    # POST /api/v1/contest/{contest_id}/pet
    # - Creates both a Pet and Participant.

    # Q: Should two separate users be able to create pets for the same contest? Don't see why not.
    # Initiate contest. Should check that it's being done by a participant
  end

end
