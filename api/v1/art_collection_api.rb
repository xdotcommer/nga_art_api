require 'grape-swagger'
require 'logger'
require_relative '../../entities'

module API
  module V1
    class ArtCollectionAPI < Grape::API
      format :json
      prefix :openaccess

      rescue_from :all do |e|
        error_response = case e
                         when Grape::Exceptions::Unauthorized
                           { error: 'unauthorized' }
                         when Grape::Exceptions::NotFound
                           { error: 'not found' }
                         else
                           { error: 'internal server error' }
                         end

        status = case e
                 when Grape::Exceptions::Unauthorized then 401
                 when Grape::Exceptions::NotFound then 404
                 else 500
                 end

        present error_response, with: Entities::ErrorResponse, status: status
      end

      helpers do
        def authenticate!(api_key)
          error!({ error: 'unauthorized' }, 401) unless valid_token?(api_key)

          #          error!('Unauthorized', 401) unless valid_token?(api_key)
        end

        def valid_token?(api_key)
          api_key.present? && api_key == '12345'
        end
      end

      before do
        content_type 'application/json'
      end

      resource :content do
        desc 'Fetch content based on id/url of an object' do
          detail 'Retrieve specific content by its ID or URL. Requires authentication.'
          success Entities::ContentResponse
          failure [
            { code: 401, message: 'Unauthorized', model: Entities::ErrorResponse,
              examples: { 'application/json' => { error: 'unauthorized' } } },
            { code: 404, message: 'Not Found', model: Entities::ErrorResponse,
              examples: { 'application/json' => { error: 'not found' } } }
          ]
        end
        params do
          requires :api_key, type: String, desc: 'The API KEY you received from https://api.data.gov/signup/'
          requires :id, type: String, desc: 'Row id, url'
        end
        get ':id' do
          authenticate!(params[:api_key])

          error!({ error: 'not found' }, 404) if params[:id] != 'edanmdm-nmaahc_2012.36.4ab'

          # error!('Not Found', 404) if params[:id] != 'edanmdm-nmaahc_2012.36.4ab'

          {
            status: 200,
            responseCode: 1,
            response: {
              id: 'edanmdm-nmaahc_2012.36.4ab',
              title: 'Drumsticks used by Art Blakey',
              unitCode: 'NMAAHC',
              linkedId: '',
              type: 'edanmdm',
              url: 'edanmdm:nmaahc_2012.36.4ab',
              content: { sample: 'content' },
              hash: 'b4c4a61ab9b71eb8777e50b5745c4ab0c75d1999',
              docSignature: '32081c6289db2620a3d2e61f453ad9330d071335',
              timestamp: 1_578_947_538,
              lastTimeUpdated: 1_578_947_529,
              version: '123-1559922770904-1559922814561-0'
            },
            message: 'content found'
          }
        end
      end

      resource :search do
        desc 'Search content based on query' do
          detail 'Use this endpoint to search for content. It supports pagination, sorting, and filtering by type or row group.'
          success Entities::SearchResponse
          failure [
            { code: 401, message: 'Unauthorized', model: Entities::ErrorResponse,
              examples: { 'application/json' => { error: 'unauthorized' } } },
            { code: 404, message: 'Not Found', model: Entities::ErrorResponse,
              examples: { 'application/json' => { error: 'not found' } } }
          ]
        end
        params do
          requires :api_key, type: String, desc: 'The API KEY you received from https://api.data.gov/signup/'
          requires :q, type: String,
                       desc: 'Search query (required). Supports boolean operators (AND, OR) and fielded searches (e.g., topic:Gastropoda).'
          optional :start, type: Integer, default: 0, desc: 'The starting row for the query. Default is 0.'
          optional :rows, type: Integer, default: 10, values: 0..1000,
                          desc: 'The number of rows to return. Default: 10, Max: 1000.'
          optional :sort, type: String, default: 'relevancy', values: %w[relevancy id newest updated random],
                          desc: 'Sort order. Default: relevancy. Options: id, newest, updated, random.'
          optional :type, type: String, default: 'edanmdm', values: %w[edanmdm ead_collection ead_component all],
                          desc: 'Filter results by content type. Default: edanmdm.'
          optional :row_group, type: String, default: 'objects', values: %w[objects archives],
                               desc: 'Row type group. Default: objects.'
        end

        get do
          authenticate!(params[:api_key])

          # Simulated search example
          error!('Not Found', 404) if params[:q].downcase == 'notfound'

          rows = [
            {
              id: 'edanmdm-nmaahc_2012.36.4ab',
              title: 'Drumsticks used by Art Blakey',
              unitCode: 'NMAAHC',
              type: 'edanmdm',
              url: 'edanmdm:nmaahc_2012.36.4ab'
            }
          ]
          present({
                    status: 200,
                    responseCode: 1,
                    response: rows,
                    message: 'Content found'
                  }, with: Entities::SearchResponse)
        end
      end
    end
  end
end
