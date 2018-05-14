#require "aws-sdk"
#include Aws

class MovieController < ApplicationController


  def index

  end

  def year
    Aws.config.update({
                          region: "us-west-2",
                          endpoint: "http://localhost:8000"
                      })

    dynamodb = Aws::DynamoDB::Client.new(
        access_key_id: 'AKIAIPYUVKSV4LQMUZ3Q',
        secret_access_key: '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'
    )

    table_name = "Movies"
    @year = params[:id]

    puts @year
    params = {
        table_name: table_name,
        key_condition_expression: "#yr = :yyyy",
        expression_attribute_names: {
            "#yr" => "year"
        },
        expression_attribute_values: {
            ":yyyy" => @year.to_i
        }
    }
    begin
      resultTest = dynamodb.query(params)

      @result = Array.new()
      resultTest.items.each{|movie|
        puts "#{movie["year"].to_i} #{movie["title"]}"
        theMovie = Array.new([movie["year"].to_i, movie["title"]])
        @result.insert(-1, theMovie)
      }
      #letters.insert(-1, 'd')
      puts "Query succeeded."


    rescue  Aws::DynamoDB::Errors::ServiceError => error
      puts "Unable to query table:"
      puts "#{error.message}"
    end

  end
end
