# main.coffee



angular.module('angularYeomanApp')
  .controller('MainCtrl', ($scope, hudlayout_res) ->
    window.$scope = $scope
    $scope.hudlayout_res = hudlayout_res

    xposToNum = (pos='0') ->
      if pos[0] is 'r'
        return 640 - (+pos.substring(1))
      if pos[0] is 'c'
        return 320 + (+pos.substring(1))
      if pos[0] is 'f' # ???? f0 seems to be 'autofit'
        return 10
      return +pos

    yposToNum = (pos='0') ->
      if pos[0] is 'r'
        return 480 - (+pos.substring(1))
      if pos[0] is 'c'
        return 240 + (+pos.substring(1))
      if pos[0] is 'f' # ????
        return 10
      return +pos

    $scope.regions = []

    editor = new fabric.Canvas 'editor'
    window.editor = editor
    hl = hudlayout_res['Resource/HudLayout.res']
    getListener = (obj, rect_json, rect) -> (args...) ->
      console.log(obj.fieldName, rect.visible, args); return
    getVisibleWatcher = (rect) -> (newValue) ->
      rect.setVisible(newValue)
      editor.renderAll()
    for key, obj of hl
      rect_json =
        left: xposToNum obj.xpos
        top: yposToNum obj.ypos
        width: xposToNum obj.wide
        height: yposToNum obj.tall
        opacity: 0.2
        fill: 'black'
        hasRotatingPoint: false
        # lockScalingY: true
        # lockScalingX: true
      rect_json.left += rect_json.width / 2
      rect_json.top += rect_json.height / 2

      if rect_json.width >= 640 or rect_json.height >= 480 then continue

      r = new fabric.Rect rect_json
      r.on('selected', getListener obj, rect_json, r)
      l = $scope.regions.push({rect: r, obj: obj})
      $scope.$watch("regions[#{l-1}].rect.visible", getVisibleWatcher(r))
      # r._obj = obj
      editor.add(r)
    # editor.on('object:selected')
    $scope.visibleAll = true
    $scope.$watch "visibleAll", (newValue) ->
      console.log newValue
      for region in $scope.regions
        region.rect.visible = newValue
    return
  )

# ["_invokeQueue",
#  "_runBlocks",
#  "requires",
#  "name",
#  "provider",
#  "factory",
#  "service",
#  "value",
#  "constant",
#  "filter",
#  "controller",
#  "directive",
#  "config",
#  "run"]