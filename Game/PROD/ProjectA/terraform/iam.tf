resource "aws_iam_policy" "ct_custom_console_acl_policy_allow" {
  name        = "ct-custom-console-acl-policy-allow"
  description = "Custom console ACL policy allow for Smilegate office IPs"

  policy = data.aws_iam_policy_document.ct_custom_console_acl_doc.json
}

data "aws_iam_policy_document" "ct_custom_console_acl_doc" {
  statement {
    sid    = "SmilegateOfficeAllow"
    effect = "Deny"

    actions   = ["*"]
    resources = ["*"]

    condition {
      test     = "NotIpAddress"
      variable = "aws:SourceIp"

      values = [
        "211.34.57.0/24",
        "165.225.228.0/23",
        "167.103.96.0/23"
      ]
    }

    condition {
      test     = "Bool"
      variable = "aws:ViaAWSService"
      values   = ["false"]
    }

    condition {
      test     = "StringNotLike"
      variable = "aws:userAgent"
      values   = ["*exec-env/CloudShell*"]
    }
  }
}
