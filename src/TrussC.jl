module TrussC
  using CxxWrap
  using TrussC_prebuilt_jll

  function get_tmp_lib_path()
    # WORKAROUND to avoid error on dll loading
    rm(normpath(joinpath(@__DIR__, "..", "tmp")), force=true, recursive=true);
    mkdir(normpath(joinpath(@__DIR__, "..", "tmp")));
    cp(TrussC_prebuilt_jll.get_lib_path(), normpath(joinpath(@__DIR__, "..", "tmp", "libJlTrussC.dll")));
    return normpath(joinpath(@__DIR__, "..", "tmp","libJlTrussC"))
  end

  # @wrapmodule(() -> TrussC_prebuilt_jll.get_lib_path())
  @wrapmodule(() -> get_tmp_lib_path())

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

end # module TrussC