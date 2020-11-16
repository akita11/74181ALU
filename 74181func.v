# 74181 ALU by Junichi Akita (akita@ifdl.jp, @akita11)

module 74181(
	     input [3:0] A, B,
	     input [3:0] S,
	     input Ci,
	     input M,
	     output [3:0] F,
	     output CP, CG,
	     output AeqB,
	     output Co
	     );
    reg [4:0] result;
    assign {Co, F} = result;

    always @(A, B, S, M, Ci) begin
	case ({S, M})
	  6'b0000_1 : result <= {0, ~A};
	  6'b0001_1 : result <= {0, ~(A | B)};
	  6'b0010_1 : result <= {0, ~A & B};
	  6'b0011_1 : result <= {0, 4'b0};
	  6'b0100_1 : result <= {0, ~(A & B)};
	  6'b0101_1 : result <= {0, ~B};
	  6'b0110_1 : result <= {0, A ^ B};
	  6'b0111_1 : result <= {0, A & ~B};
	  6'b1000_1 : result <= {0, ~A | B};
	  6'b1001_1 : result <= {0, ~(A ^ B)};
	  6'b1010_1 : result <= {0, B};
	  6'b1011_1 : result <= {0, A & B};
	  6'b1100_1 : result <= {0, 4'b1111};
	  6'b1101_1 : result <= {0, A | ~B};
	  6'b1110_1 : result <= {0, A | B};
	  6'b1111_1 : result <= {0, A};

	  6'b0000_0_1 : result <= A + ~Ci;
	  6'b0001_0_1 : result <= A | B + ~Ci;
	  6'b0010_0_1 : result <= A | ~B + ~Ci;
	  6'b0011_0_1 : result <= 5'b11111 + ~Ci;
	  6'b0100_0_1 : result <= A + (A & ~B) + ~Ci;
	  6'b0101_0_1 : result <= (A | B) + (A & ~B) + ~Ci;
	  6'b0110_0_1 : result <= A - B - 1 + ~Ci;
	  6'b0111_0_1 : result <= (A & ~B) - 1 + ~Ci;
	  6'b1000_0_1 : result <= A + (A & B) + ~Ci;
	  6'b1001_0_1 : result <= A + B + ~Ci;
	  6'b1010_0_1 : result <= (A | ~B) + (A & B) + ~Ci;
	  6'b1011_0_1 : result <= (A & B) - 1 + ~Ci;
	  6'b1100_0_1 : result <= A + A + ~Ci;
	  6'b1101_0_1 : result <= (A | B) + A + ~Ci;
	  6'b1110_0_1 : result <= (A | ~B) + A + ~Ci;
	  6'b1111_0_1 : result <= A - 1 + ~Ci;
	endcase
    end
endmodule
