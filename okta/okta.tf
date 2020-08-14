resource "oktaasa_project" "asa_project" {
  project_name = "${var.project}"
}

resource "oktaasa_enrollment_token" "enrollment_token" {
  project_name = "${oktaasa_project.asa_project.project_name}"
  description  = "ASA enrollment token for project"
}

resource "oktaasa_assign_group" "group-assignment" {
  project_name  = "${oktaasa_project.asa_project.project_name}"
  group_name    = "${var.group}"
  server_access = true
  server_admin  = true
}