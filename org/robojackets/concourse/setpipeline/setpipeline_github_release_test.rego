package org.robojackets.concourse.setpipeline

test_github_release_with_access_token_allowed {
	not reasons["github-release resources must authenticate with an app token"] with input as {"data": {"resources": [{
		"source": {"access_token": "((\"github.com\"/token.token))"},
		"type": "github-release",
	}]}}
}

test_github_release_with_no_credentials_disallowed {
	reasons == {"github-release resources must authenticate with an app token"} with input as {"data": {"resources": [{
		"source": {},
		"tags": ["resources"],
		"type": "github-release",
	}]}}
}

test_github_release_with_wrong_credentials_disallowed {
	reasons == {"github-release resources must authenticate with an app token"} with input as {"data": {"resources": [{
		"source": {"access_token": "jkl"},
		"tags": ["resources"],
		"type": "github-release",
	}]}}
}
