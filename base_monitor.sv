class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)
  
  virtual alu_interface vif;
  alu_item item;
  
  uvm_analysis_port #(alu_item) mon_port;
  
  
  function new (string name= "alu_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS", "Inside constructor", UVM_HIGH)
    
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS", "Build phase", UVM_HIGH)
    
    mon_port = new ("mon_port", this);
    
    if(!(uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif))) begin
      `uvm_error("MONITOR_CLASS", "Failed to get VIF from config DB")
    end
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS", "Connect phase", UVM_HIGH)
    
  endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS", "Run phase", UVM_HIGH)
	forever begin
      item = alu_item::type_id::create("item");
      
      wait(!vif.reset)
      //sample input
      @(posedge vif.clock);
      item.a = vif.a;
      item.b = vif.b;
      item.op_code = vif.op_code;
      
      //sample output
      @(posedge vif.clock);
      item.result = vif.result;
      
      //send item to scoreboard
      mon_port.write(item);
    end
    
  endtask: run_phase
  
endclass: alu_monitor