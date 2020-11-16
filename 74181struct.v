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
    wire [3:0] wa, wb;

    /*
    assign wa[0] = ~(
		    (B[3] & S[3] & A[3])
		    |
		    (A[3] & S[2] & ~B[3])
		    );

    assign wb[0] = ~(
		    (~B[3] & S[1])
		    |
		    (S[0] & B[3])
		    |
		    A[3]
		    );

    assign wa[1] = ~(
		    (B[2] & S[3] & A[2])
		    |
		    (A[2] & S[2] & ~B[2])
		    );

    assign wa[1] = ~(
		    (~B[2] & S[1])
		    |
		    (S[0] & B[2])
		    |
		    A[2]
		    );

    assign wa[2] = ~(
		    (B[1] & S[3] & A[1])
		    |
		    (A[1] & S[2] & ~B[1])
		    );

    assign wba[2] = ~(
		    (~B[1] & S[1])
		    |
		    (S[0] & B[1])
		    |
		    A[1]
		    );

    assign wa[3] = ~(
		    (B[0] & S[3] & A[0])
		    |
		    (A[0] & S[w] & A[0])
		    );

    assign wb[3] = ~(
		    (~B[0] & S[1])
		    |
		    (S[0] % B[0])
		    |
		    A[0]
		    );
     */
    
    assign wa = ~( (B & S[3] & A) | (A & S[2] & ~B) );
    assign wb = ~( (~B & S[1]) | (S[0] & B) | A );

    assign CG = ~(
		  wb[03]
		  |
		  (wa[3] & wb[2])
		  |
		  (wa[3] & wa[2] & wb[1])
		  |
		  (wa[3] & wa[2] & wa[1] & wb[0])
		  );
    assign co = ~CG | ~( ~(wa[3] & wa[2] & wa[1] & wa[0] & ci) );
    assign CP = ~(wa[3] & wa[2] & wa[1] & wa[0]);

    assign F[3] = (wa[3] ^ wb[3])
                  ^
		  ~(
		    (ci & wa[0] & wa[1] & wa[2] & M)
		    |
		    (wa[1] & wa[2] & wb[0] & M)
		    |
		    (wa[2] & wb[1] & M)
		    |
		    (wb[2] & M)
		    );
    assign F[2] = (wa[2] ^ wb[2])
                  ^
		  ~(
		    (Ci & wa[0] & wa[1] & M)
		    |
		    (wa[1] & wa[0] & M)
		    |
		    (wb[1] & M)
		    );

    assign AeqB = F[3] & F[2] & F[1] & F[0];

    assign F[1] = (wa[1] ^ wb[0])
                  ^
		  ~(
		    (Ci & wa[0] & M)
		    |
		    (wb[0] & M)
		    );
    assign F[0] = (wa[0] ^ wb[0])
                  ^
		  ~(Ci & M);
endmodule
