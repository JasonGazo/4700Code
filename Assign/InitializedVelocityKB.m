function [ v ] = InitializedVelocityKB( f,m,T,kb)
v=sqrt(log(f/(sqrt(m/(2*pi*kb*T))))/(-m/(2*kb*T)));
end

