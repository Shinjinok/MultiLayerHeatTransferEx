# trace generated using paraview version 5.9.0

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

# create a new 'Sphere'
sphere1 = Sphere(registrationName='Sphere1')

# get active view
renderView1 = GetActiveViewOrCreate('RenderView')

# show data in view
sphere1Display = Show(sphere1, renderView1, 'GeometryRepresentation')

# trace defaults for the display properties.
sphere1Display.Representation = 'Surface'
sphere1Display.ColorArrayName = [None, '']
sphere1Display.SelectTCoordArray = 'None'
sphere1Display.SelectNormalArray = 'Normals'
sphere1Display.SelectTangentArray = 'None'
sphere1Display.OSPRayScaleArray = 'Normals'
sphere1Display.OSPRayScaleFunction = 'PiecewiseFunction'
sphere1Display.SelectOrientationVectors = 'None'
sphere1Display.ScaleFactor = 0.1
sphere1Display.SelectScaleArray = 'None'
sphere1Display.GlyphType = 'Arrow'
sphere1Display.GlyphTableIndexArray = 'None'
sphere1Display.GaussianRadius = 0.005
sphere1Display.SetScaleArray = ['POINTS', 'Normals']
sphere1Display.ScaleTransferFunction = 'PiecewiseFunction'
sphere1Display.OpacityArray = ['POINTS', 'Normals']
sphere1Display.OpacityTransferFunction = 'PiecewiseFunction'
sphere1Display.DataAxesGrid = 'GridAxesRepresentation'
sphere1Display.PolarAxes = 'PolarAxesRepresentation'

# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
sphere1Display.ScaleTransferFunction.Points = [-0.9749279022216797, 0.0, 0.5, 0.0, 0.9749279022216797, 1.0, 0.5, 0.0]

# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
sphere1Display.OpacityTransferFunction.Points = [-0.9749279022216797, 0.0, 0.5, 0.0, 0.9749279022216797, 1.0, 0.5, 0.0]

# reset view to fit data
renderView1.ResetCamera()

# get the material library
materialLibrary1 = GetMaterialLibrary()

# update the view to ensure updated data information
renderView1.Update()

# Properties modified on sphere1
sphere1.ThetaResolution = 20

# update the view to ensure updated data information
renderView1.Update()

# create a new 'Clip'
clip1 = Clip(registrationName='Clip1', Input=sphere1)
clip1.ClipType = 'Plane'
clip1.HyperTreeGridClipper = 'Plane'
clip1.Scalars = [None, '']

# Properties modified on clip1
clip1.Scalars = ['POINTS', '']

# show data in view
clip1Display = Show(clip1, renderView1, 'UnstructuredGridRepresentation')

# trace defaults for the display properties.
clip1Display.Representation = 'Surface'
clip1Display.ColorArrayName = [None, '']
clip1Display.SelectTCoordArray = 'None'
clip1Display.SelectNormalArray = 'Normals'
clip1Display.SelectTangentArray = 'None'
clip1Display.OSPRayScaleArray = 'Normals'
clip1Display.OSPRayScaleFunction = 'PiecewiseFunction'
clip1Display.SelectOrientationVectors = 'None'
clip1Display.ScaleFactor = 0.1
clip1Display.SelectScaleArray = 'None'
clip1Display.GlyphType = 'Arrow'
clip1Display.GlyphTableIndexArray = 'None'
clip1Display.GaussianRadius = 0.005
clip1Display.SetScaleArray = ['POINTS', 'Normals']
clip1Display.ScaleTransferFunction = 'PiecewiseFunction'
clip1Display.OpacityArray = ['POINTS', 'Normals']
clip1Display.OpacityTransferFunction = 'PiecewiseFunction'
clip1Display.DataAxesGrid = 'GridAxesRepresentation'
clip1Display.PolarAxes = 'PolarAxesRepresentation'
clip1Display.ScalarOpacityUnitDistance = 0.2905200790232579
clip1Display.OpacityArrayName = ['POINTS', 'Normals']

# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
clip1Display.ScaleTransferFunction.Points = [-0.9749279022216797, 0.0, 0.5, 0.0, 0.0, 1.0, 0.5, 0.0]

# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
clip1Display.OpacityTransferFunction.Points = [-0.9749279022216797, 0.0, 0.5, 0.0, 0.0, 1.0, 0.5, 0.0]

# hide data in view
Hide(sphere1, renderView1)

# update the view to ensure updated data information
renderView1.Update()

#================================================================
# addendum: following script captures some of the application
# state to faithfully reproduce the visualization during playback
#================================================================

# get layout
layout1 = GetLayout()

#--------------------------------
# saving layout sizes for layouts

# layout/tab size in pixels
layout1.SetSize(1469, 525)

#-----------------------------------
# saving camera placements for views

# current camera placement for renderView1
renderView1.CameraPosition = [1.4125679628139487, -2.9544012761926077, 0.3205119512460959]
renderView1.CameraViewUp = [-0.07747511798087507, 0.0708441210442213, 0.9944740904655692]
renderView1.CameraParallelScale = 0.8516115354228021

#--------------------------------------------
# uncomment the following to render all views
# RenderAllViews()
# alternatively, if you want to write images, you can use SaveScreenshot(...).