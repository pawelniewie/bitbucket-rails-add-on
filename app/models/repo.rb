class Repo < ActiveRecord::Base
  belongs_to :jwt_token

  def self.number_of_stars(jwt_auth, repo_name)
    repo_table = Repo.arel_table

    count_sql = repo_table.project(Arel.star.count.as('count'))
                    .where(repo_table[:repo_name].eq(repo_name)).to_sql

    starred_sql = repo_table.project(Arel.star.count.as('starred'))
                      .where(repo_table[:repo_name].eq(repo_name).and repo_table[:jwt_token_id].eq(jwt_auth.id)).to_sql

    results = ActiveRecord::Base.connection.exec_query("SELECT (#{count_sql}), (#{starred_sql})").last

    {
        count: results['count'],
        starred: results['starred'] > 0
    }
  end

end