package org.robojackets.concourse.useimage

reasons["image type must be registry-image"] {
	input.data.image_type != "registry-image"
}

reasons["only concourse/oci-build-task is allowed to run in a privileged container"] {
	input.data.privileged == true
	input.data.image_source.repository != "concourse/oci-build-task"
}

reasons["concourse/oci-build-task requires a privileged container"] {
	input.data.privileged != true
	input.data.image_source.repository == "concourse/oci-build-task"
}
