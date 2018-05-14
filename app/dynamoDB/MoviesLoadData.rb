require "aws-sdk"
require "json"

Aws.config.update({
                      region: "us-west-2",
                      endpoint: "http://localhost:8000"
                  })

dynamodb = Aws::DynamoDB::Client.new(
  access_key_id: 'AKIAIPYUVKSV4LQMUZ3Q',
  secret_access_key: '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'
)

table_name = 'Movies'

file = File.read('moviedata.json')
movies = JSON.parse(file)
movies.each{|movie|

  params = {
      table_name: table_name,
      item: movie
  }

  begin
    result = dynamodb.put_item(params)
    puts "Added movie: #{movie["year"]} #{movie["title"]}"

  rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to add movie:"
    puts "#{error.message}"
  end
}

