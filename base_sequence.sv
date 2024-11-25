class alu_sequence extends uvm_sequence;
  `uvm_object_utils(alu_sequence)
  
  alu_item reset_pkt;
  
  function new (string name = "alu_sequence");
    super.new(name);
    `uvm_info("BASE_SEQ", "Inside constructor", UVM_HIGH)
  endfunction: new
  
  task body();
    `uvm_info("BASE_SEQ", "Inside body task", UVM_HIGH)
    reset_pkt = alu_item::type_id::create("reset_pkt");
    start_item(reset_pkt);
    reset_pkt.randomize() with {reset == 1;};
    finish_item(reset_pkt);
    
  endtask: body
  
endclass: alu_sequence
//////////////////////////////////////////////
class alu_test_sequence extends alu_sequence;
  `uvm_object_utils(alu_test_sequence)
  
  alu_item item;
  
  function new (string name = "alu_test_sequence");
    super.new(name);
    `uvm_info("TEST_SEQ", "Inside constructor", UVM_HIGH)
  endfunction: new
  
  task body();
    `uvm_info("TEST_SEQ", "Inside body task", UVM_HIGH)
    item = alu_item::type_id::create("item");
    start_item(item);
    item.randomize() with {reset == 0;};
    finish_item(item);
    
  endtask: body
  
  
  
endclass: alu_test_sequence