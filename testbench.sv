// Code your testbench here
// or browse Examples

`timescale 1ns/1ns

//import uvm_pkg::*;
`include "uvm_macros.svh"

//include files
`include "dut_if.sv"
`include "base_item.sv"
`include "base_sequence.sv"
`include "base_sequencer.sv"
`include "base_driver.sv"
`include "base_monitor.sv"
`include "base_agent.sv"
`include "base_scoreboard.sv"
`include "base_env.sv"
`include "base_test.sv"

module top;
  //instantiation
  
  logic clock;
  
  alu_interface intf(.clock(clock));
  
  alu dut(
    .clock(intf.clock),
    .reset(intf.reset),
    .A(intf.a),
    .B(intf.b),
    .ALU_Sel(intf.op_code),
    .ALU_Out(intf.result),
    .CarryOut(intf.carry_out)
  );
  
  //interface setting
  initial begin
    uvm_config_db #(virtual alu_interface)::set(null, "*", "vif", intf);
  end
  
  // run test
  initial begin
    run_test("alu_test");
  end
  
  initial begin
    clock =0;
    #10;
    forever begin
      clock = ~clock;
      #1;
    end
  end
  
  initial begin
    #5000;
    $display("End of simulation");
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  
endmodule:top