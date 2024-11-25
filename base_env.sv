class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)
  
  alu_agent agent;
  alu_scoreboard scoreboard;
  
  function new (string name= "alu_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ENV_CLASS", "Inside constructor", UVM_HIGH)
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ENV_CLASS", "Build phase", UVM_HIGH)
    
    agent = alu_agent::type_id::create("agent",this);
    scoreboard = alu_scoreboard::type_id::create("scoreboard",this);
    
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV_CLASS", "Connect phase", UVM_HIGH)
    
    agent.mon.mon_port.connect(scoreboard.scoreboard_port);
    
  endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
  endtask: run_phase
  
endclass: alu_env