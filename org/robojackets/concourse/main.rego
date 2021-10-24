package org.robojackets.concourse

import data.org.robojackets.concourse.createbuild.reasons as createbuild_reasons
import data.org.robojackets.concourse.setpipeline.reasons as setpipeline_reasons
import data.org.robojackets.concourse.useimage.reasons as useimage_reasons

default allowed = true

allowed = false {
	count(reasons) > 0
}

reasons = ["cluster configuration error"] {
	input.action != "CreateBuild"
	input.action != "SaveConfig"
	input.action != "SetPipeline"
	input.action != "UseImage"
}

reasons = createbuild_reasons {
	input.action == "CreateBuild"
}

reasons = setpipeline_reasons {
	input.action == "SaveConfig"
}

reasons = setpipeline_reasons {
	input.action == "SetPipeline"
}

reasons = useimage_reasons {
	input.action == "UseImage"
}
