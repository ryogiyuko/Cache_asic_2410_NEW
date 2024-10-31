
`timescale 1ns / 1ps

module cSplitter2_cache(
i_drive, o_free,
o_driveNext0, i_freeNext0,
o_driveNext1, i_freeNext1,
rstn);

input i_drive;
input i_freeNext0,i_freeNext1;
input rstn;

output o_free;
output o_driveNext0,o_driveNext1;

wire [1:0] w_outRRelay_2,w_outARelay_2;
wire w_fire;
wire w_freeNext,w_free0Next,w_free1Next;
wire w_driveNext0;
wire w_sendFree;
wire w_sendDrive;
wire w_firstTrig, w_firstReq;
wire w_secondTrig, w_secondReq;
wire w_delayFree0Next,w_delayFree1Next;
(* dont_touch="true" *)delay4U indelay1 (.inR(i_freeNext0), .outR(w_delayFree0Next), .rstn(rstn));

(* dont_touch="true" *)delay4U indelay2 (.inR(i_freeNext1), .outR(w_delayFree1Next), .rstn(rstn));


(* dont_touch="true" *)delay2U outdelay1 (.inR(w_delayFree0Next), .outR(w_free0Next), .rstn(rstn));

assign w_firstTrig = w_delayFree0Next | w_sendDrive;

contTap firstTap(
.trig(w_firstTrig),
.req(w_firstReq),
.rstn(rstn)
);

(* dont_touch="true" *)delay2U outdelay2 (.inR(w_delayFree1Next), .outR(w_free1Next), .rstn(rstn));

assign w_secondTrig = w_delayFree1Next | w_sendDrive;

contTap secondTap(
.trig(w_secondTrig),
.req(w_secondReq),
.rstn(rstn)
);

assign w_freeNext = w_free0Next | w_free1Next;
assign w_sendFree = w_freeNext & !(w_secondReq | w_firstReq);
assign w_sendDrive = i_drive;
assign o_free = w_sendFree;
assign o_driveNext0 = i_drive;
assign o_driveNext1 = i_drive;

endmodule


