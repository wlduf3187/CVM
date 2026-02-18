clear; close all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: Symbolic validation of the simplified representation for a vehicle-trailer system
% Author: Jiyeol Oh
% Last modified: 2026-02-19
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
syms m1 m2 Izz1 Izz2 real
syms lf1 lr1 P lf2 lr2 real
syms Vx Cy1 Cy2 Cy3 real
syms M D [5 5] real
syms F [5 1] real
syms M0 D0 T0 [4 4] real
syms F0 [4 1] real

L1 = lf1+lr1; L2 = lf2+lr2;

M(:) = 0;
D(:) = 0;
F(:) = 0;

M(1,1) = m1; M(1,5) = 1;
M(2,2) = Izz1; M(2,5) = -(lr1+P);
M(3,3) = m2; M(3,5) = -1;
M(4,4) = Izz2; M(4,5) = -lf2;
M(5,1) = 1; M(5,2) = -(lr1+P); M(5,3) = -1; M(5,4) = -lf2;

D(1,1) = -(Cy1+Cy2)/Vx; D(1,2) = -m1*Vx - (lf1*Cy1-lr1*Cy2)/Vx;
D(2,1) = -(lf1*Cy1-lr1*Cy2)/Vx; D(2,2) = -(lf1^2*Cy1+lr1^2*Cy2)/Vx;
D(3,3) = -Cy3/Vx; D(3,4) = -m2*Vx + (lr2*Cy3)/Vx;
D(4,3) = (lr2*Cy3)/Vx; D(4,4) = -(lr2^2*Cy3)/Vx;
D(5,2) = -Vx; D(5,4) = Vx;
F(1) = Cy1;
F(2) = lf1*Cy1;

Minv = M^-1;
A = Minv*D;
B = Minv*F;

M0(:) = 0;
D0(:) = 0;
F0(:) = 0;

M0(1,1) = 1 + m2/m1 * lr2/L2;
M0(1,2) = 1/(m1*L2*Vx) * (Izz2 - m2*lr2*(lr1+P+lf2));
M0(1,3) = -1/(m1*L2*Vx) * (Izz2 - m2*lf2*lr2);

M0(2,1) = - m2*Vx*(lr1+P)/Izz1 * lr2/L2;
M0(2,2) = 1 - (lr1+P)*(Izz2 - m2*lr2*(lr1+P+lf2))/(Izz1*L2);
M0(2,3) = (lr1+P)*(Izz2 - m2*lr2*lf2)/(Izz1*L2);

M0(3,1) = -m2*lf2*lr2*Vx/(Izz2*L2);
M0(3,2) = lr2/L2 * (Izz2 + m2*lf2*(lr1+P+lf2))/Izz2;
M0(3,3) = -lr2/L2 * (Izz2 + m2*lf2^2)/Izz2;

M0(4,4) = 1;

D0(1,1) = - (Cy1+Cy2)/(m1*Vx);
D0(1,2) = - (1 + lr2/L2 * m2/m1 + (lf1*Cy1-lr1*Cy2)/(m1*Vx^2));

D0(2,1) = - (lf1*Cy1 - lr1*Cy2)/Izz1;
D0(2,2) = lr2/L2 * (m2*Vx*(lr1+P))/Izz1 - (lf1^2*Cy1 + lr1^2*Cy2)/(Izz1*Vx);
D0(3,1) = lr2*Cy3/Izz2;
D0(3,2) = m2*lf2*lr2*Vx/(Izz2*L2) - lr2*(lr1+P+L2)*Cy3/(Izz2*Vx);
D0(3,3) = lr2*L2*Cy3/(Izz2*Vx);
D0(3,4) = lr2*Cy3/Izz2;

D0(4,3) = 1;

F0(1) = Cy1/(m1*Vx);
F0(2) = lf1*Cy1/(Izz1);
%%
M0inv = M0^-1;
A0 = M0inv*D0;
B0 = M0inv*F0;

% similarity transformation from [beta1; r1; rh; psih] to [Vy1; r1; Vy2; r2]
T0(:) = 0;
T0(1,1) = Vx;
T0(2,2) = 1;
T0(3,1) = Vx; T0(3,2) = -(lr1+P+lf2); T0(3,3) = lf2; T0(3,4) = Vx;
T0(4,2) = 1; T0(4,3) = -1;

A0_t = T0*A0*T0^-1;
B0_t = T0*B0;
%%
A_diff = A(1:4,1:4) - A0_t;
B_diff = B(1:4) - B0_t;

A_diff_simplified = simplify(A_diff);
B_diff_simplified = simplify(B_diff);

result_map_A = arrayfun(@(x) isAlways(x == 0), A_diff_simplified);
fprintf('For matrix A,\n');
if all(result_map_A, 'all')
    fprintf('Success: both models are identical.\n');
else
    [row, col] = find(~result_map_A);
    fprintf('Warning: Differences found in %d elements..\n', length(row));

    for i = 1:length(row)
        fprintf('Difference at [%d, %d] element:\n', row(i), col(i));
        disp(simplify(A_diff(row(i), col(i))));
    end
end

fprintf('For matrix B,\n');
result_map_B = arrayfun(@(x)isAlways(x==0), B_diff_simplified);
if all(result_map_B, 'all')
    fprintf('Success: both models are identical.\n');
else
    [row, col] = find(~result_map_B);
    fprintf('Warning: Differences found in %d elements..\n', length(row));
    
    for i = 1:length(row)
        fprintf('Difference at [%d, %d] element:\n', row(i), col(i));
        disp(simplify(B_diff(row(i), col(i))));
    end
end