`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/10 10:23:04
// Design Name: 
// Module Name: uart_txd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_txd
(
    input          I_clk           , //50MHz
    input          I_rst_n         , // ϵͳȫ�ָ�λ
    input          I_tx_start      , // ����ʹ���ź�
    input          I_bps_tx_clk    , // ���Ͳ�����ʱ��
    input   [7:0]  I_para_data     , // Ҫ���͵Ĳ�������
    output  reg    O_rs232_txd     , // ���͵Ĵ������ݣ���Ӳ�����봮������
    output  reg    O_bps_tx_clk_en , // ������ʱ��ʹ���ź�
    output  reg    O_tx_done         // ������ɵı�־
);

reg  [3:0]  R_state ;

reg R_transmiting ; // �������ڷ��ͱ�־

/////////////////////////////////////////////////////////////////////////////
// �������� R_transmiting ��־λ
/////////////////////////////////////////////////////////////////////////////
always @(posedge I_clk or negedge I_rst_n)
begin
    if(!I_rst_n)
        R_transmiting <= 1'b0 ;
    else if(O_tx_done)
        R_transmiting <= 1'b0 ;
    else if(I_tx_start)
        R_transmiting <= 1'b1 ;          
end

/////////////////////////////////////////////////////////////////////////////
// ��������״̬��
/////////////////////////////////////////////////////////////////////////////
always @(posedge I_clk or negedge I_rst_n)
begin
    if(!I_rst_n)
        begin
            R_state      <= 4'd0 ;
            O_rs232_txd  <= 1'b1 ; 
            O_tx_done    <= 1'b0 ;
            O_bps_tx_clk_en <= 1'b0 ;
        end 
    else if(R_transmiting)
        begin
            O_bps_tx_clk_en <= 1'b1 ;
            if(I_bps_tx_clk)
                begin
                    case(R_state)
                        4'd0  :
                            begin
                                O_rs232_txd  <= 1'b0            ;
                                O_tx_done    <= 1'b0            ; 
                                R_state      <= R_state + 1'b1  ;
                            end
                        4'd1  : //I_para_data[0]
                            begin
                                O_rs232_txd  <= I_para_data[0]  ;
                                O_tx_done    <= 1'b0            ; 
                                R_state      <= R_state + 1'b1  ;
                            end 
                        4'd2  : //I_para_data[1]
                            begin
                                O_rs232_txd  <= I_para_data[1]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd3  : //I_para_data[2]
                            begin
                                O_rs232_txd  <= I_para_data[2]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd4  : //I_para_data[3]
                            begin
                                O_rs232_txd  <= I_para_data[3]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end 
                        4'd5  : //I_para_data[4]
                            begin
                                O_rs232_txd  <= I_para_data[4]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd6  : //I_para_data[5]
                            begin
                                O_rs232_txd  <= I_para_data[5]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd7  : //I_para_data[6]
                            begin
                                O_rs232_txd  <= I_para_data[6]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end
                        4'd8  : //I_para_data[7]
                            begin
                                O_rs232_txd  <= I_para_data[7]   ;
                                O_tx_done    <= 1'b0             ; 
                                R_state      <= R_state + 1'b1   ;
                            end 
                        4'd9  : //end
                            begin
                                O_rs232_txd  <= 1'b1 ;
                                O_tx_done      <= 1'b1 ; 
                                R_state           <= 4'd0 ;
                            end
                        default :R_state      <= 4'd0 ;
                endcase 
            end 
        end 
    else 
        begin 
            O_bps_tx_clk_en <= 1'b0  ;
            R_state               <= 4'd0  ; 
            O_tx_done         <= 1'b0  ; 
            O_rs232_txd     <= 1'b1  ;  
         end 
end 

endmodule
