using PointsOnASphere
using Test

@testset "Constructor" begin
	r,θ,ϕ = 2,pi/2,pi/3 

	@testset "Point2D" begin
		n = Point2D(θ,ϕ)
	    @test n.θ == θ
	    @test n.ϕ == ϕ

	    n = Point2D(θ,ϕ + 2pi)
	    @test n.ϕ ≈ ϕ

	    n = Point2D(θ,ϕ - 2pi)
	    @test n.ϕ ≈ ϕ

	    @test_throws AssertionError Point2D(-θ,ϕ)
	end

	@testset "Point3D" begin
		x = Point3D(r,θ,ϕ)
		@test x.r == r
		@test x.θ == θ
	    @test x.ϕ == ϕ

	    x = Point3D(r,θ,ϕ + 2pi)
	    @test x.ϕ ≈ ϕ

	    x = Point3D(r,θ,ϕ - 2pi)
	    @test x.ϕ ≈ ϕ
	    
	    @test_throws AssertionError Point3D(r,-θ,ϕ)
	    @test_throws AssertionError Point3D(-r,θ,ϕ)
	end
end