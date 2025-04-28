resource "aws_codecommit_repository" "code_repo" {
  repository_name = "cap-1-repo"

  description = "CodeCommit repository for cap-1 project"
}
