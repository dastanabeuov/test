class GistQuestionService
  
  def initialize(question, client: default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def default_client
    Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'])
  end

  def call
    @client.create_gist(gist_params.to_json)
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist.question_title', test_title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end
  
end