using PointsOnASphere
using Test

@testset "Constructor" begin
	r,θ,ϕ = 2,pi/2,pi/3 

	@testset "Point2D" begin
		n = Point2D(θ,ϕ)
	    @test n.θ == θ
	    @test n.ϕ == ϕ

	    @test Point2D(n) === n

	    n2 = Point2D((θ,ϕ))
	    @test n2 == n

	    n3 = Point2D(Point3D(1,θ,ϕ))
	    @test n3 == n

	    @test_throws ArgumentError Point2D(θ,ϕ + 2pi)
	    @test_throws ArgumentError Point2D(θ,ϕ - 2pi)
	    @test_throws ArgumentError Point2D(θ+π,ϕ)
	    @test_throws ArgumentError Point2D(-θ,ϕ)
	end

	@testset "Point3D" begin
		x = Point3D(r,θ,ϕ)
		@test x.r == r
		@test x.θ == θ
	    @test x.ϕ == ϕ

	    @test Point3D(x) === x

	    x2 = Point3D(r,(θ,ϕ))
	    @test x2 == x

	    x3 = Point3D(r,Point2D(θ,ϕ))
	    @test x3 == x

	    x4 = Point3D((θ,ϕ))
	    @test x4.r == 1
	    @test x4.θ == θ
	    @test x4.ϕ == ϕ

	    x5 = Point3D(Point2D(θ,ϕ))
	    @test x4 == x5

	    x6 = Point3D((r,θ,ϕ))
	    @test x6 == x

	    @test_throws ArgumentError Point3D(r,θ,ϕ + 2pi)
	    @test_throws ArgumentError Point3D(r,θ,ϕ - 2pi)
	    @test_throws ArgumentError Point3D(r,θ+π,ϕ)
	    @test_throws ArgumentError Point3D(r,-θ,ϕ)
	    @test_throws ArgumentError Point3D(-r,θ,ϕ)
	end
end

@testset "show" begin
	r,θ,ϕ = 2,pi/2,pi/3 

	io = IOBuffer()
	pt = Point2D(θ,ϕ)
	show(io,pt)
	strexp = "(θ=$(round(pt.θ,sigdigits=3)), ϕ=$(round(pt.ϕ,sigdigits=3)))"
	@test String(take!(io)) == strexp
	
	show(io,MIME"text/plain"(),pt)
	strexp = "(θ=$(pt.θ), ϕ=$(pt.ϕ))"
	@test String(take!(io)) == strexp

	pt = Point3D(1,θ,ϕ)
	show(io,pt)
	strexp = "(r=$(round(pt.r,sigdigits=3)), θ=$(round(pt.θ,sigdigits=3)), ϕ=$(round(pt.ϕ,sigdigits=3)))"
	@test String(take!(io)) == strexp

	show(io,MIME"text/plain"(),pt)
	strexp = "(r=$(pt.r), θ=$(pt.θ), ϕ=$(pt.ϕ))"
	@test String(take!(io)) == strexp
end