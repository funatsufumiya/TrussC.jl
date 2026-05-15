module TrussC
  using CxxWrap
  using TrussC_prebuilt_jll

  function get_tmp_lib()
    # WORKAROUND to avoid error on dll loading
    rm(normpath(joinpath(@__DIR__, "..", "tmp")), force=true, recursive=true);
    mkdir(normpath(joinpath(@__DIR__, "..", "tmp")));
    lib_path = TrussC_prebuilt_jll.get_lib_path()
    lib_name = basename(lib_path)
    cp(lib_path, normpath(joinpath(@__DIR__, "..", "tmp", lib_name)), force=true);
    return normpath(joinpath(@__DIR__, "..", "tmp", lib_name))
  end

  # @wrapmodule(() -> TrussC_prebuilt_jll.get_lib_path())
  @wrapmodule(() -> get_tmp_lib())

  function __init__()
    @initcxx
  end

  Vec2Ref = CxxRef{TrussC.Vec2}
  Vec3Ref = CxxRef{TrussC.Vec3}
  FilesRef = CxxRef{StdVector{StdString}}

  macro setup(fn)
    return :( TrussC.setSetupFn(@cfunction($fn, Cvoid, ())) )
  end

  macro update(fn)
    return :( TrussC.setUpdateFn(@cfunction($fn, Cvoid, ())) )
  end

  macro draw(fn)
    return :( TrussC.setDrawFn(@cfunction($fn, Cvoid, ())) )
  end

  macro keyPressed(fn)
    return :( TrussC.setKeyPressedFn(@cfunction($fn, Cvoid, (Cint,))) )
  end

  macro keyReleased(fn)
    return :( TrussC.setKeyReleasedFn(@cfunction($fn, Cvoid, (Cint,))) )
  end

  macro mousePressed(fn)
    return :( TrussC.setMousePressedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref, Cint,))) )
  end

  macro mouseReleased(fn)
    return :( TrussC.setMouseReleasedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref, Cint,))) )
  end

  macro mouseMoved(fn)
    return :( TrussC.setMouseMovedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref,))) )
  end

  macro mouseScrolled(fn)
    return :( TrussC.setMouseScrolledFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref,))) )
  end

  macro mouseDragged(fn)
    return :( TrussC.setMouseDraggedFn(@cfunction($fn, Cvoid, (TrussC.Vec2Ref, Cint,))) )
  end

  macro windowResized(fn)
    return :( TrussC.setWindowResizedFn(@cfunction($fn, Cvoid, (Cint, Cint,))) )
  end

  macro filesDropped(fn)
    return :( TrussC.setFilesDroppedFn(@cfunction($fn, Cvoid, (TrussC.FilesRef,))) )
  end

  macro exit(fn)
    return :( TrussC.setExitFn(@cfunction($fn, Cvoid, ())) )
  end

  Base.:+(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.add(x, y)
  Base.:*(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.mul(x, y)
  Base.:/(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.div(x, y)
  Base.:-(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.sub(x, y)
  Base.:(==)(x::TrussC.Vec2, y::TrussC.Vec2) = TrussC.eq(x, y)
  Base.:+(x::TrussC.Vec2, y::Number) = TrussC.add(x, y)
  Base.:*(x::TrussC.Vec2, y::Number) = TrussC.mul(x, y)
  Base.:/(x::TrussC.Vec2, y::Number) = TrussC.div(x, y)
  Base.:-(x::TrussC.Vec2, y::Number) = TrussC.sub(x, y)
  Base.:+(y::Number, x::TrussC.Vec2) = TrussC.add(x, y)
  Base.:*(y::Number, x::TrussC.Vec2) = TrussC.mul(x, y)

  Base.:+(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.add(x, y)
  Base.:*(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.mul(x, y)
  Base.:/(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.div(x, y)
  Base.:-(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.sub(x, y)
  Base.:(==)(x::TrussC.Vec3, y::TrussC.Vec3) = TrussC.eq(x, y)
  Base.:+(x::TrussC.Vec3, y::Number) = TrussC.add(x, y)
  Base.:*(x::TrussC.Vec3, y::Number) = TrussC.mul(x, y)
  Base.:/(x::TrussC.Vec3, y::Number) = TrussC.div(x, y)
  Base.:-(x::TrussC.Vec3, y::Number) = TrussC.sub(x, y)
  Base.:+(y::Number, x::TrussC.Vec3) = TrussC.add(x, y)
  Base.:*(y::Number, x::TrussC.Vec3) = TrussC.mul(x, y)

  Base.:+(x::TrussC.Vec4, y::TrussC.Vec4) = TrussC.add(x, y)
  Base.:-(x::TrussC.Vec4, y::TrussC.Vec4) = TrussC.sub(x, y)
  Base.:(==)(x::TrussC.Vec4, y::TrussC.Vec4) = TrussC.eq(x, y)
  Base.:+(x::TrussC.Vec4, y::Number) = TrussC.add(x, y)
  Base.:*(x::TrussC.Vec4, y::Number) = TrussC.mul(x, y)
  Base.:/(x::TrussC.Vec4, y::Number) = TrussC.div(x, y)
  Base.:-(x::TrussC.Vec4, y::Number) = TrussC.sub(x, y)
  Base.:+(y::Number, x::TrussC.Vec4) = TrussC.add(x, y)
  Base.:*(y::Number, x::TrussC.Vec4) = TrussC.mul(x, y)

  Base.:*(x::TrussC.Mat4, y::TrussC.Mat4) = TrussC.mul(x, y)
  Base.:*(x::TrussC.Mat4, y::TrussC.Vec4) = TrussC.mul(x, y)
  Base.:*(x::TrussC.Mat4, y::TrussC.Vec3) = TrussC.mul(x, y)
  Base.:(==)(x::TrussC.Mat4, y::TrussC.Mat4) = TrussC.eq(x, y)

  Base.:(==)(x::TrussC.Quaternion, y::TrussC.Quaternion) = TrussC.eq(x, y)

  Base.show(io::IO, v::TrussC.Vec2) = print(io, "Vec2(",TrussC.x(v),", ",TrussC.y(v),")")
  Base.show(io::IO, v::TrussC.Vec3) = print(io, "Vec3(",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),")")
  Base.show(io::IO, v::TrussC.Vec4) = print(io, "Vec4(",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),", ",TrussC.w(v),")")
  Base.show(io::IO, v::TrussC.Quaternion) = print(io, "Quaternion(",TrussC.w(v),", ",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),")")
  Base.show(io::IO, v::TrussC.Color) = print(io, "Color(",TrussC.r(v),", ",TrussC.g(v),", ",TrussC.b(v),", ",TrussC.a(v),")")

  export x, y, z, w, 
    r, g, b, a,
    Vec2, Vec3, Vec4, Mat4, Rect, Color, Quaternion, Pixels,
    Light, Material, LogStream, FpsSettings,
    LogLevel, BlendMode, TextureFilter, TextureWrap, StrokeCap,
    StrokeJoin, Direction, Cursor, Orientation, Shader,
    Texture, Image,
    runTrusscTestApp,
    runTrusscApp,
    setSetupFn,
    setUpdateFn,
    setDrawFn,
    setKeyPressedFn,
    setKeyReleasedFn,
    setMousePressedFn,
    setMouseReleasedFn,
    setMouseMovedFn,
    setMouseScrolledFn,
    setMouseDraggedFn,
    setWindowResizedFn,
    setFilesDroppedFn,
    getElapsedTimef,
    deg2rad,
    rad2deg,
    clamp,
    remap,
    sign,
    fract,
    sq,
    dist,
    distSquared,
    wrap,
    angleDifference,
    angleDifferenceDeg,
    random,
    randomInt,
    randomSeed,
    logLevelToString,
    tcSetConsoleLogLevel,
    tcSetFileLogLevel,
    tcSetLogFile,
    tcCloseLogFile,
    tcLog,
    logVerbose,
    logNotice,
    logWarning,
    logError,
    logFatal,
    tcLogVerbose,
    tcLogNotice,
    tcLogWarning,
    tcLogError,
    tcLogFatal,
    getDpiScale,
    getFramebufferWidth,
    getFramebufferHeight,
    beginFrame,
    clear,
    flushDeferredShaderDraws,
    ensureSwapchainPass,
    present,
    isInSwapchainPass,
    suspendSwapchainPass,
    resumeSwapchainPass,
    setColor,
    getColor,
    setColorHSB,
    setColorOKLab,
    setColorOKLCH,
    fill,
    noFill,
    setStrokeWeight,
    getStrokeWeight,
    setStrokeCap,
    getStrokeCap,
    setStrokeJoin,
    getStrokeJoin,
    setScissor,
    setScissor,
    resetScissor,
    pushScissor,
    popScissor,
    pushMatrix,
    popMatrix,
    pushStyle,
    popStyle,
    resetStyle,
    translate,
    rotate,
    rotate,
    rotateX,
    rotateY,
    rotateZ,
    rotateDeg,
    rotateXDeg,
    rotateYDeg,
    rotateZDeg,
    scale,
    getCurrentMatrix,
    resetMatrix,
    setMatrix,
    setBlendMode,
    getBlendMode,
    resetBlendMode,
    restoreBlendPipeline,
    enable3D,
    enable3DPerspective,
    setupScreenFov,
    setupScreenPerspective,
    setupScreenOrtho,
    getDefaultScreenFov,
    setNearClip,
    setFarClip,
    getNearClip,
    getFarClip,
    worldToScreen,
    screenToWorld,
    disable3D,
    drawRect,
    drawRectRounded,
    drawRectSquircle,
    drawCircle,
    drawEllipse,
    drawLine,
    drawTriangle,
    drawPoint,
    drawPoint,
    setCircleResolution,
    getCircleResolution,
    isFillEnabled,
    isStrokeEnabled,
    drawBitmapString,
    setTextAlign,
    getTextAlignH,
    getTextAlignV,
    setBitmapLineHeight,
    getBitmapFontHeight,
    getBitmapStringWidth,
    getBitmapStringHeight,
    getBitmapStringBBox,
    drawBitmapStringHighlight,
    setWindowTitle,
    showCursor,
    hideCursor,
    setCursor,
    getCursor,
    bindCursorImage,
    bindCursorImage,
    unbindCursorImage,
    setClipboardString,
    getClipboardString,
    setWindowSize,
    setFullscreen,
    isFullscreen,
    toggleFullscreen,
    setOrientation,
    getWindowWidth,
    getWindowHeight,
    getWindowSize,
    getAspectRatio,
    getElapsedTime,
    getUpdateCount,
    getDrawCount,
    getFrameCount,
    getDeltaTime,
    getFrameRate,
    getSokolMemoryBytes,
    getSokolMemoryAllocs,
    releaseSglBuffers,
    getGlobalMouseX,
    getGlobalMouseY,
    getGlobalPMouseX,
    getGlobalPMouseY,
    isMousePressed,
    getMouseButton,
    isKeyPressed,
    getMouseY,
    getMousePos,
    getGlobalMousePos,
    setTouchAsMouse,
    getTouchAsMouse,
    getBackendName,
    getMemoryUsage,
    getNodeCount,
    getTextureCount,
    getFboCount,
    setFps,
    setIndependentFps,
    getFpsSettings,
    getFps,
    redraw,
    requestExitApp,
    exitApp,
    grabScreen,
    registerInspectionTools,
    registerDebuggerTools,
    createPlane,
    createBox,
    createSphere,
    createCylinder,
    createCone,
    createIcoSphere,
    createTorus,
    drawBox,
    drawSphere,
    drawCone,
    addLight,
    removeLight,
    clearLights,
    getNumLights,
    setMaterial,
    clearMaterial,
    beginShadowPass,
    endShadowPass,
    shadowDraw,
    setCameraPosition,
    getCameraPosition,
    Vec2Ref,
    Vec3Ref,
    FilesRef

end # module TrussC
