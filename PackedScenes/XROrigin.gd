extends XROrigin3D

@export var vr_mode = true
var xr_interface: XRInterface

func _ready():
	if vr_mode:
		xr_interface = XRServer.find_interface("OpenXR")
		if xr_interface and xr_interface.is_initialized():
			print("OpenXR initialized successfully")

			# Turn off v-sync!
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

			# Change our main viewport to output to the HMD
			get_viewport().use_xr = true
		else:
			print("OpenXR not initialized, please check if your headset is connected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
