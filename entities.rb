require 'grape'
require 'grape-entity'

module Entities
  class ErrorResponse < Grape::Entity
    expose :error, documentation: {
      type: 'String',
      desc: 'Error message',
      examples: {
        unauthorized: 'unauthorized',
        not_found: 'not found'
      }
    }
  end

  class BaseRow < Grape::Entity
    expose :id, documentation: {
      type: 'String',
      desc: 'Unique identifier for the content.',
      example: 'edanmdm-nmaahc_2012.36.4ab'
    }
    expose :title, documentation: {
      type: 'String',
      desc: 'Title of the content.',
      example: 'Drumsticks used by Art Blakey'
    }
    expose :unitCode, documentation: {
      type: 'String',
      desc: 'Unit code associated with the content.',
      example: 'NMAAHC'
    }
    expose :type, documentation: {
      type: 'String',
      desc: 'Type of the content.',
      example: 'edanmdm'
    }
    expose :url, documentation: {
      type: 'String',
      desc: 'URL for the content.',
      example: 'edanmdm:nmaahc_2012.36.4ab'
    }
  end

  class BaseResponse < Grape::Entity
    expose :status, documentation: {
      type: 'Integer',
      desc: 'HTTP status code.',
      example: 200
    }
    expose :responseCode, documentation: {
      type: 'Integer',
      desc: 'Custom response code.',
      example: 1
    }
    expose :message, documentation: {
      type: 'String',
      desc: 'Response message.',
      example: 'content found'
    }
  end

  class Content < Grape::Entity
    expose :content, documentation: {
      type: 'String',
      desc: 'content',
      example: 'sample'
    }
  end

  class ContentRow < BaseRow
    expose :linkedId, documentation: {
      type: 'String',
      desc: 'Linked identifier.',
      example: ''
    }
    expose :content, using: Entities::Content, documentation: {
      desc: 'Content details.'
    }
    expose :hash, documentation: {
      type: 'String',
      desc: 'Content hash.',
      example: 'b4c4a61ab9b71eb8777e50b5745c4ab0c75d1999'
    }
    expose :docSignature, documentation: {
      type: 'String',
      desc: 'Document signature.',
      example: '32081c6289db2620a3d2e61f453ad9330d071335'
    }
    expose :timestamp, documentation: {
      type: 'Integer',
      desc: 'Timestamp of creation.',
      example: 1_578_947_538
    }
    expose :lastTimeUpdated, documentation: {
      type: 'Integer',
      desc: 'Last update timestamp.',
      example: 1_578_947_529
    }
    expose :version, documentation: {
      type: 'String',
      desc: 'Version information.',
      example: '123-1559922770904-1559922814561-0'
    }
  end

  class Row < BaseRow
  end

  class ContentResponse < BaseResponse
    expose :response, using: Entities::ContentRow, documentation: {
      desc: 'Content response data.'
    }
  end

  class SearchResponse < BaseResponse
    expose :response, using: Entities::Row, documentation: {
      is_array: true,
      desc: 'Array of rows in the response.'
    }
  end
end
