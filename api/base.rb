require 'grape'
require_relative 'v1/art_collection_api'

module API
  class Base < Grape::API
    format :json

    mount API::V1::ArtCollectionAPI

    add_swagger_documentation(
      api_version: 'v1.0',
      doc_version: '0.0.1',
      hide_documentation_path: true,
      mount_path: '/docs',
      produces: ['application/json'],
      info: {
        title: 'National Gallery Open Access API',
        description: <<~DESC
          **Explore National Gallery Open Access content using this API**

          Unlock the full potential of the national gallery's art collection with our Open Access API. Browse through our curated collections, discover new artworks, or dive deep into
          specific themes with our advanced search functionality.

          **Key Endpoints:**

          * **Search**: Search for artworks across the national gallery's extensive collections.
          * **Content**: Access a wide range of high-quality content, including metadata, descriptions, and images.

          **What you can gain from using this API:**

          * A vast library of high-quality content to power your applications or experiences
          * Innovative ways to engage with art and artists
          * Insights into the world's greatest art collections

        DESC
      },
      hide_documentation_path: true
    )
  end
end
