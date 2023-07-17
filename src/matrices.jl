# tipos numéricos
1::Int32
1.0::Float32
(1.0+2.0im)::ComplexF32

# basicos
A = [1 2; 3 4] # matriz cuadrada
A = Int32[1 2; 3 4] # tipo explícito
B = [1; 2;; 3; 4;; 5; 6;;; 7; 8;; 9; 10;; 11; 12] # tensor
size(B) # (2, 3, 2)
A[1] # elemento inicial
A[end] # elemento final
B[1, 1:end, :] # slicing

# comprehensions
Float32[ 0.25*x[i-1] + 0.5*x[i] + 0.25*x[i+1] for i=2:length(x)-1 ]
[ a + b*im for a=range(0, 1, 10), b=range(0,1,10)]