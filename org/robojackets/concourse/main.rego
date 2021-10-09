package org.robojackets.concourse

import data.org.robojackets.concourse.setpipeline.reasons as setpipeline_reasons
import data.org.robojackets.concourse.useimage.reasons as useimage_reasons

default allowed = true

allowed = false {
	count(reasons) > 0
}

reasons = ["cluster configuration error"] {
	input.action != "UseImage"
	input.action != "SetPipeline"
	input.action != "SaveConfig"
}

reasons = useimage_reasons {
	input.action == "UseImage"
}

reasons = setpipeline_reasons {
	input.action == "SetPipeline"
}

reasons = setpipeline_reasons {
	input.action == "SaveConfig"
}
