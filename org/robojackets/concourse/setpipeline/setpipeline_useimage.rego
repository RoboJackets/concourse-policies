package org.robojackets.concourse.setpipeline

reasons["image type must be registry-image"] {
	[path, value] := walk(input.data.jobs[_])
	value.task
	value.config.image_resource.type != "registry-image"
}

reasons["only concourse/oci-build-task is allowed to run in a privileged container"] {
	[path, value] := walk(input.data.jobs[_])
	value.task
	value.config.image_resource.source.repository != "concourse/oci-build-task"
	value.privileged == true
}

reasons["concourse/oci-build-task requires a privileged container"] {
	[path, value] := walk(input.data.jobs[_])
	value.task
	value.config.image_resource.source.repository == "concourse/oci-build-task"
	value.privileged != true
}
