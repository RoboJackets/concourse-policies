package org.robojackets.concourse.useimage

test_docker_image_disallowed {
	reasons == {"image type must be registry-image"} with input as {"data": {"image_type": "docker-image"}}
}

test_any_other_type_disallowed {
	reasons == {"image type must be registry-image"} with input as {"data": {"image_type": "something"}}
}

test_registry_image_allowed {
	not reasons["image type must be registry-image"] with input as {"data": {"image_type": "registry-image"}}
}

test_oci_build_task_privileged_allowed {
	not reasons["only concourse/oci-build-task is allowed to run in a privileged container"] with input as {"data": {
		"image_source": {"repository": "concourse/oci-build-task"},
		"image_type": "registry-image",
		"privileged": true,
	}}
}

test_oci_build_task_privileged_required {
	reasons == {"concourse/oci-build-task requires a privileged container"} with input as {"data": {
		"image_source": {"repository": "concourse/oci-build-task"},
		"image_type": "registry-image",
		"privileged": false,
	}}
}

test_other_privileged_disallowed {
	reasons == {"only concourse/oci-build-task is allowed to run in a privileged container"} with input as {"data": {
		"image_source": {"repository": "something"},
		"image_type": "registry-image",
		"privileged": true,
	}}
}

test_both_rules_disallowed {
	reasons == {
		"only concourse/oci-build-task is allowed to run in a privileged container",
		"image type must be registry-image",
	} with input as {"data": {
		"image_source": {"repository": "something"},
		"image_type": "docker-image",
		"privileged": true,
	}}
}
