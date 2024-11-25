class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)
  
  uvm_analysis_imp #(alu_item, alu_scoreboard) scoreboard_port;
  
  alu_item transactions[$];
  alu_item curr_trans;
  
  function new (string name= "alu_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCOREBOARD_CLASS", "Inside constructor", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "Build phase", UVM_HIGH)
    
    scoreboard_port = new ("scoreboard_port", this);
    
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "Connect phase", UVM_HIGH)
    
  endfunction: connect_phase
  
  //write method
  function void write (alu_item item);
    transactions.push_back(item);
  endfunction: write
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "Run phase", UVM_HIGH)
    
    forever begin
      //get the packet
      //generate expected value
      //compare it with actual value
      //score the transactions accordingly
      wait(transactions.size()!=0);
      curr_trans = transactions.pop_front();
      compare(curr_trans);
      
    end
  endtask: run_phase
  
  task compare(alu_item item);
    // generate expected result and compare with actual
    logic [7:0] expected;
    logic [7:0] actual;
    
    case (curr_trans.op_code)
      0: begin
        expected = curr_trans.a + curr_trans.b;
      end
      1: begin
        expected = curr_trans.a - curr_trans.b;
      end
      2: begin
        expected = curr_trans.a * curr_trans.b;
      end
      3: begin
        expected = curr_trans.a / curr_trans.b;
      end
    endcase
    
    actual = curr_trans.result;
    
    if (actual != expected) begin
      `uvm_error(get_type_name(), $sformatf("Transaction failed! Actual = %d, Expected = %d", actual, expected))
    end else begin
      `uvm_info(get_type_name(), $sformatf("Transaction Pass"), UVM_LOW)
    end
    
  endtask: compare
  
endclass: alu_scoreboard