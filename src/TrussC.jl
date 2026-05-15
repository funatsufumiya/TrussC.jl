module TrussC
  using CxxWrap
  using TrussC_prebuilt_jll

  StdVector = CxxWrap.StdVector

  function get_tmp_lib()
    # WORKAROUND to avoid error on dll loading
    tmp_dir = normpath(joinpath(@__DIR__, "..", "tmp"))
    # rm(tmp_dir, force=true, recursive=true)
    if !isdir(tmp_dir)
      mkdir(tmp_dir)
    end
    lib_path = TrussC_prebuilt_jll.get_lib_path()
    lib_name = basename(lib_path)
    cp(lib_path, normpath(joinpath(tmp_dir, lib_name)), force=true);
    return normpath(joinpath(tmp_dir, lib_name))
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

  Base.:+(x::TrussC.IVec2, y::TrussC.IVec2) = TrussC.add(x, y)
  Base.:-(x::TrussC.IVec2, y::TrussC.IVec2) = TrussC.sub(x, y)
  Base.:(==)(x::TrussC.IVec2, y::TrussC.IVec2) = TrussC.eq(x, y)
  Base.:+(x::TrussC.IVec2, y::Number) = TrussC.add(x, y)
  Base.:*(x::TrussC.IVec2, y::Number) = TrussC.mul(x, y)
  Base.:-(x::TrussC.IVec2, y::Number) = TrussC.sub(x, y)
  Base.:+(y::Number, x::TrussC.IVec2) = TrussC.add(x, y)
  Base.:*(y::Number, x::TrussC.IVec2) = TrussC.mul(x, y)

  Base.:+(x::TrussC.IVec3, y::TrussC.IVec3) = TrussC.add(x, y)
  Base.:-(x::TrussC.IVec3, y::TrussC.IVec3) = TrussC.sub(x, y)
  Base.:(==)(x::TrussC.IVec3, y::TrussC.IVec3) = TrussC.eq(x, y)
  Base.:+(x::TrussC.IVec3, y::Number) = TrussC.add(x, y)
  Base.:*(x::TrussC.IVec3, y::Number) = TrussC.mul(x, y)
  Base.:-(x::TrussC.IVec3, y::Number) = TrussC.sub(x, y)
  Base.:+(y::Number, x::TrussC.IVec3) = TrussC.add(x, y)
  Base.:*(y::Number, x::TrussC.IVec3) = TrussC.mul(x, y)

  Base.:*(x::TrussC.Mat4, y::TrussC.Mat4) = TrussC.mul(x, y)
  Base.:*(x::TrussC.Mat4, y::TrussC.Vec4) = TrussC.mul(x, y)
  Base.:*(x::TrussC.Mat4, y::TrussC.Vec3) = TrussC.mul(x, y)
  Base.:(==)(x::TrussC.Mat4, y::TrussC.Mat4) = TrussC.eq(x, y)

  Base.:*(x::TrussC.Mat3, y::TrussC.Mat3) = TrussC.mul(x, y)
  Base.:*(x::TrussC.Mat3, y::TrussC.Vec3) = TrussC.mul(x, y)
  Base.:*(x::TrussC.Mat3, y::TrussC.Vec2) = TrussC.mul(x, y)
  Base.:(==)(x::TrussC.Mat3, y::TrussC.Mat3) = TrussC.eq(x, y)

  Base.:(==)(x::TrussC.Quaternion, y::TrussC.Quaternion) = TrussC.eq(x, y)

  Base.getindex(x::TrussC.Json, y::Number) = TrussC.at(x, y)
  Base.getindex(x::TrussC.Json, y::String) = TrussC.at(x, y)
  Base.setindex!(x::TrussC.Json, v, y::Number) = TrussC.set(x, y, v)
  Base.setindex!(x::TrussC.Json, v, y::String) = TrussC.set(x, y, v)

  Base.show(io::IO, v::TrussC.Vec2) = print(io, "Vec2(",TrussC.x(v),", ",TrussC.y(v),")")
  Base.show(io::IO, v::TrussC.Vec3) = print(io, "Vec3(",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),")")
  Base.show(io::IO, v::TrussC.Vec4) = print(io, "Vec4(",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),", ",TrussC.w(v),")")
  Base.show(io::IO, v::TrussC.IVec2) = print(io, "IVec2(",TrussC.x(v),", ",TrussC.y(v),")")
  Base.show(io::IO, v::TrussC.IVec3) = print(io, "IVec3(",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),")")
  Base.show(io::IO, v::TrussC.Quaternion) = print(io, "Quaternion(",TrussC.w(v),", ",TrussC.x(v),", ",TrussC.y(v),", ",TrussC.z(v),")")
  Base.show(io::IO, v::TrussC.Color) = print(io, "Color(",TrussC.r(v),", ",TrussC.g(v),", ",TrussC.b(v),", ",TrussC.a(v),")")
  Base.show(io::IO, v::TrussC.Json) = print(io, "Json(",TrussC.toJsonString(v),")")

  export x, y, z, w, width, height, set, set!, x!, y!, z!, w!,
    r, g, b, a, r!, g!, b!, a!,
    Vec2, Vec3, Vec4, IVec2, IVec3, Mat4, Mat3, Rect, Color, Quaternion, Mesh, Texture, Pixels,
    toEuler,
    conjugate,
    rotate,
    length,
    lengthSquared,
    normalized,
    normalize,
    determinant,
    transposed,
    inverted,
    limit,
    dot,
    cross,
    distance,
    distanceSquared,
    lerp,
    reflected,
    xy,
    toVec2,
    toVec3,
    toMatrix,
    toHex,
    toLinear,
    toHSB,
    toOKLab,
    toOKLCH,
    clamped,
    lerpRGB,
    lerpLinear,
    lerpHSB,
    lerpOKLab,
    lerpOKLCH,
    lerp,
    Quaternion_identity,
    Quaternion_fromAxisAngle,
    Quaternion_fromEuler,
    Quaternion_slerp,
    Mat4_identity,
    Mat4_translate,
    Mat4_rotateX,
    Mat4_rotateY,
    Mat4_rotateZ,
    Mat4_rotate,
    Mat4_scale,
    Mat4_lookAt,
    Mat4_ortho,
    Mat4_perspective,
    Mat4_frustum,
    Mat3_identity,
    Mat3_getHomography,
    Mat3_rotate,
    Mat3_scale,
    Mat3_translate,
    Light, Material, LogStream, FpsSettings,
    LogLevel, BlendMode, TextureFilter, TextureWrap, StrokeCap,
    StrokeJoin, Direction, Cursor, Orientation, Shader, EasyCam, ShaderVertex,
    PrimitiveType,
    Image,
    PrimitiveMode,
    setMode,
    getMode,
    addVertex,
    addVertices,
    getVertices,
    getNumVertices,
    addColor,
    addColors,
    getColors,
    getNumColors,
    hasColors,
    addIndex,
    addIndices,
    addTriangle,
    getIndices,
    hasIndices,
    addNormal,
    addNormals,
    setNormal,
    getNormal,
    getNormals,
    getNumNormals,
    hasNormals,
    addTexCoord,
    addTexCoord,
    getTexCoords,
    hasTexCoords,
    hasValidTexCoords,
    addTangent,
    getTangents,
    getNumTangents,
    hasTangents,
    clear,
    clearVertices,
    clearNormals,
    clearColors,
    clearIndices,
    clearTexCoords,
    clearTangents,
    translate,
    translate,
    rotateX,
    rotateY,
    rotateZ,
    scale,
    transform,
    append,
    draw,
    drawNoLighting,
    drawWithLighting,
    drawNoLightingWithTexture,
    drawWireframe,
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
    FilesRef,
    @setup,
    @update,
    @draw,
    @keyPressed,
    @keyReleased,
    @mousePressed,
    @mouseReleased,
    @mouseMoved,
    @mouseScrolled,
    @mouseDragged,
    @windowResized,
    @filesDropped,
    @exit,

    TextureFormat, Fbo, StdFileSystemPath,
    c_str,
    string,
    allocate,
    clear,
    begin_fbo,
    clearColor,
    end_fbo,
    readPixels,
    readPixelsFloat,
    copyTo,
    getWidth,
    getHeight,
    getSampleCount,
    getTextureFormat,
    isAllocated,
    isActive,
    getTexture,
    save,
    getColorImage,
    getTextureView,
    getSampler,

    Color_fromBytes,
    Color_fromHex,
    Color_fromHSB,
    Color_fromOKLCH,
    Color_fromOKLab,
    Color_fromLinear,

    # color constants
    Color_white,
    Color_black,
    Color_red,
    Color_green,
    Color_blue,
    Color_yellow,
    Color_cyan,
    Color_magenta,
    Color_transparent,
    Color_gray,
    Color_darkGray,
    Color_dimGray,
    Color_lightGray,
    Color_silver,
    Color_gainsboro,
    Color_whiteSmoke,
    Color_darkRed,
    Color_fireBrick,
    Color_crimson,
    Color_indianRed,
    Color_lightCoral,
    Color_salmon,
    Color_darkSalmon,
    Color_lightSalmon,
    Color_orange,
    Color_darkOrange,
    Color_orangeRed,
    Color_tomato,
    Color_coral,
    Color_gold,
    Color_goldenRod,
    Color_darkGoldenRod,
    Color_paleGoldenRod,
    Color_lightGoldenRodYellow,
    Color_khaki,
    Color_darkKhaki,
    Color_lime,
    Color_limeGreen,
    Color_lightGreen,
    Color_paleGreen,
    Color_darkGreen,
    Color_forestGreen,
    Color_seaGreen,
    Color_mediumSeaGreen,
    Color_darkSeaGreen,
    Color_lightSeaGreen,
    Color_springGreen,
    Color_mediumSpringGreen,
    Color_greenYellow,
    Color_yellowGreen,
    Color_chartreuse,
    Color_lawnGreen,
    Color_olive,
    Color_oliveDrab,
    Color_darkOliveGreen,
    Color_aqua,
    Color_aquamarine,
    Color_mediumAquaMarine,
    Color_darkCyan,
    Color_teal,
    Color_lightCyan,
    Color_turquoise,
    Color_mediumTurquoise,
    Color_darkTurquoise,
    Color_paleTurquoise,
    Color_navy,
    Color_darkBlue,
    Color_mediumBlue,
    Color_royalBlue,
    Color_steelBlue,
    Color_blueSteel,
    Color_lightSteelBlue,
    Color_dodgerBlue,
    Color_deepSkyBlue,
    Color_skyBlue,
    Color_lightSkyBlue,
    Color_lightBlue,
    Color_powderBlue,
    Color_cornflowerBlue,
    Color_cadetBlue,
    Color_midnightBlue,
    Color_aliceBlue,
    Color_purple,
    Color_darkMagenta,
    Color_darkViolet,
    Color_blueViolet,
    Color_indigo,
    Color_slateBlue,
    Color_darkSlateBlue,
    Color_mediumSlateBlue,
    Color_mediumPurple,
    Color_darkOrchid,
    Color_mediumOrchid,
    Color_orchid,
    Color_violet,
    Color_plum,
    Color_thistle,
    Color_lavender,
    Color_fuchsia,
    Color_pink,
    Color_lightPink,
    Color_hotPink,
    Color_deepPink,
    Color_mediumVioletRed,
    Color_paleVioletRed,
    Color_brown,
    Color_maroon,
    Color_saddleBrown,
    Color_sienna,
    Color_chocolate,
    Color_peru,
    Color_sandyBrown,
    Color_burlyWood,
    Color_tan,
    Color_rosyBrown,
    Color_snow,
    Color_honeyDew,
    Color_mintCream,
    Color_azure,
    Color_ghostWhite,
    Color_floralWhite,
    Color_ivory,
    Color_antiqueWhite,
    Color_linen,
    Color_lavenderBlush,
    Color_mistyRose,
    Color_oldLace,
    Color_seaShell,
    Color_beige,
    Color_cornsilk,
    Color_lemonChiffon,
    Color_lightYellow,
    Color_wheat,
    Color_moccasin,
    Color_peachPuff,
    Color_papayaWhip,
    Color_blanchedAlmond,
    Color_bisque,
    Color_navajoWhite,
    Color_slateGray,
    Color_lightSlateGray,
    Color_darkSlateGray,

    allocateCubemap,
    uploadCubemapFace,
    uploadCubemapMip,
    getCubemapFaceAttachmentView,
    isCubemap,
    getNumMipLevels,
    allocateCompressed,
    updateCompressed,
    isCompressed,
    clear,
    isAllocated,
    getWidth,
    getHeight,
    getChannels,
    getUsage,
    getSampleCount,
    getPixelFormat,
    loadData,
    setMinFilter,
    setMagFilter,
    setFilter,
    getMinFilter,
    getMagFilter,
    setPremultipliedAlpha,
    isPremultipliedAlpha,
    setWrapU,
    setWrapV,
    setWrap,
    getWrapU,
    getWrapV,
    drawSubsection,
    bind,
    unbind,
    getImage,
    getView,
    getSampler,
    getAttachmentView,

    getFormat,
    isFloat,
    getTotalBytes,
    getData,
    getDataF32,
    getDataVoid,
    getColor,
    setColor,
    setFromPixels,
    setFromFloats,
    copyTo,
    clone,
    load,
    loadHDR,
    loadPlatform,
    loadFromMemory,

    begin_shader,
    end_shader,
    setUniform,
    storeUniform,
    applyUniforms,
    setTexture,
    submitVertices,
    executeDeferredDraw,

    begin_cam,
    begin_easycam,
    end_cam,
    end_easycam,
    setTarget,
    getTarget,
    setUpAxis,
    getUpAxis,
    setDistance,
    getDistance,
    setFov,
    getFov,
    getPosition,
    setFovDeg,
    setNearClip,
    setFarClip,
    setSensitivity,
    setZoomSensitivity,
    setPanSensitivity,
    setControlArea,
    clearControlArea,
    enableMouseInput,
    disableMouseInput,
    isMouseInputEnabled,
    mousePressed,
    mouseReleased,
    mouseDragged,
    mouseScrolled,

    LightType, IesProfile,

    setDirectional,
    setPoint,
    setSpot,
    getSpotInnerCos,
    getSpotOuterCos,
    setProjectionTexture,
    getProjectionTexture,
    hasProjectionTexture,
    setLensShift,
    getLensShiftX,
    getLensShiftY,
    setProjectorAspect,
    getProjectorAspect,
    computeProjectorViewProj,
    setIesProfile,
    getIesProfile,
    hasIesProfile,
    enableShadow,
    disableShadow,
    isShadowEnabled,
    getShadowResolution,
    setShadowBias,
    getShadowBias,
    getType,
    getDirection,
    getPosition,
    setAmbient,
    setDiffuse,
    setSpecular,
    getAmbient,
    getDiffuse,
    getSpecular,
    getIntensity,
    setIntensity,
    setAttenuation,
    getConstantAttenuation,
    getLinearAttenuation,
    getQuadraticAttenuation,
    enable,
    disable,
    isEnabled,
    calculate,

    getBaseColor,
    setBaseColor,
    setMetallic,
    getMetallic,
    setRoughness,
    getRoughness,
    setAo,
    getAo,
    getEmissiveStrength,
    setEmissiveStrength,
    getEmissive,
    setEmissive,
    setNormalMap,
    getNormalMap,
    hasNormalMap,
    setBaseColorTexture,
    getBaseColorTexture,
    hasBaseColorTexture,
    setMetallicRoughnessTexture,
    getMetallicRoughnessTexture,
    hasMetallicRoughnessTexture,
    setEmissiveTexture,
    getEmissiveTexture,
    hasEmissiveTexture,
    setOcclusionTexture,
    getOcclusionTexture,
    hasOcclusionTexture,

    Json,
    get_string,
    get_double,
    get_float,
    get_int,
    get_bool,
    empty,
    loadJson,
    saveJson,
    saveJson,
    parseJson,
    toJsonString

end # module TrussC
