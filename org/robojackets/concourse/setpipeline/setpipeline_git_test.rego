package org.robojackets.concourse.setpipeline

test_git_with_access_token_allowed {
	not reasons["git resources must authenticate with an app token"] with input as {"data": {"resources": [{
		"source": {
			"password": "((\"github.com\"/token.token))",
			"username": "x-access-token",
		},
		"type": "git",
	}]}}
}

test_git_with_no_credentials_disallowed {
	reasons == {"git resources must authenticate with an app token"} with input as {"data": {"resources": [{
		"source": {},
		"tags": ["resources"],
		"type": "git",
	}]}}
}

test_git_with_wrong_credentials_disallowed {
	reasons == {"git resources must authenticate with an app token"} with input as {"data": {"resources": [{
		"source": {"password": "jkl", "username": "asdf"},
		"tags": ["resources"],
		"type": "git",
	}]}}
}
