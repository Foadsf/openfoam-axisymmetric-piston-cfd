#### import the simple module from the paraview
from paraview.simple import *

# Load the foam file
case = OpenFOAMReader(FileName='case.foam')
case.MeshRegions = ['internalMesh']
case.CellArrays = ['U', 'p']

# Get animation scene
animationScene = GetAnimationScene()
animationScene.UpdateAnimationUsingDataTimeSteps()

# Create a new 'Render View'
renderView = CreateView('RenderView')
renderView.Background = [0.2, 0.2, 0.2]  # Dark gray background

# Show data in view
caseDisplay = Show(case, renderView)

# Color by velocity magnitude
ColorBy(caseDisplay, ('POINTS', 'U', 'Magnitude'))

# Get color transfer function and set range
uLUT = GetColorTransferFunction('U')
uLUT.ApplyPreset('Cool to Warm', True)
uLUT.RescaleTransferFunction(0.0, 2.0)  # Set velocity range

# Show color bar
caseDisplay.SetScalarBarVisibility(renderView, True)

# Get scalar bar and customize
colorBar = GetScalarBar(uLUT, renderView)
colorBar.Title = 'Velocity Magnitude (m/s)'
colorBar.ComponentTitle = ''

# Set camera for better view
renderView.CameraPosition = [0.025, 0.015, 0.025]
renderView.CameraFocalPoint = [0.005, 0, 0.025]
renderView.CameraViewUp = [0, 0, 1]

# Fit view
renderView.ResetCamera()

# Set animation parameters
animationScene.NumberOfFrames = 100
animationScene.StartTime = 0.0
animationScene.EndTime = 2.0

# Save animation
SaveAnimation('animation.mp4', renderView, FrameRate=25)

print("Animation saved as animation.mp4")
print("Frames: 100, Duration: 2s at 25 FPS")
