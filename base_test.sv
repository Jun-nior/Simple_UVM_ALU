class alu_test extends uvm_test;
  `uvm_component_utils(alu_test)
  
  alu_env env;
  alu_sequence reset_seq;
  alu_test_sequence test_seq;
  
  function new (string name= "alu_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST_CLASS", "Inside constructor", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "Build phase", UVM_HIGH)
    
    env = alu_env::type_id::create("env",this);
    
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS", "Connect phase", UVM_HIGH)
    
    //connect monitor to scoreboard
    
  endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "Run phase", UVM_HIGH)
    
    phase.raise_objection(this);
    
    //start reset_seq
    reset_seq = alu_sequence::type_id::create("reset_seq");
    reset_seq.start(env.agent.seqr);
    #8;
    
    //test seq
    repeat(100) begin
   	  test_seq = alu_test_sequence::type_id::create("test_seq");
      test_seq.start(env.agent.seqr);
      #8;
    end
    
    phase.drop_objection(this);
    
  endtask: run_phase
  
endclass: alu_test