# OBS Bucket Start
resource "huaweicloud_obs_bucket" "this" {
  bucket        = "${var.env}-${var.app_name}-${var.svc["obs"]}"
  storage_class = "STANDARD"
  acl           = "private"

  tags = var.default_tags
}
############################################################################# OBS Bucket End
