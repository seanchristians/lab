resource "github_repository_environment" "development" {
  environment         = "development"
  repository          = "lab"
  can_admins_bypass   = true
  prevent_self_review = false
}

resource "github_repository_environment" "production" {
  environment         = "production"
  repository          = "lab"
  can_admins_bypass   = true
  prevent_self_review = false

  reviewers {
    users = data.github_user.seanchristians.id
  }
}
