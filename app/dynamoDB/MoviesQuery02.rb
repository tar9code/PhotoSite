require "aws-sdk"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new(
  access_key_id: 'AKIAIPYUVKSV4LQMUZ3Q',
  secret_access_key: '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'
)

table_name = "Movies"

params = {
    table_name: table_name,
    projection_expression: "#yr, title, info.genres, info.actors[0]",
    key_condition_expression: 
        "#yr = :yyyy and title between :letter1 and :letter2",
    expression_attribute_names: {
        "#yr" => "year"
    },
    expression_attribute_values: {
        ":yyyy" => 1992,
        ":letter1" => "A",
        ":letter2" => "L"
    }
}

puts "Querying for movies from 1992 - titles A-L, with genres and lead actor";

begin
    result = dynamodb.query(params)
    puts "Query succeeded."
    
    result.items.each{|movie|
         print "#{movie["year"].to_i}: #{movie["title"]} ... "

         movie['info']['genres'].each{|gen| 
            print gen + " "
         }
        
         print " ... #{movie["info"]["actors"][0]}\n"
    }

rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to query table:"
    puts "#{error.message}"
end
