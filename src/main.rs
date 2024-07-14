use wasmtime::*;

fn main() -> wasmtime::Result<()> {
    // get filename from 1st arg
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        eprintln!("Usage: {} <filename>", args[0]);
        std::process::exit(1);
    }

    let filename = &args[1];

    let engine = Engine::default();
    let mut store = Store::new(&engine, ());
    let module = Module::from_file(&engine, filename)?;

    let print = Func::wrap(&mut store, |param: i32| {
        println!("WASM print: {}", param);
    });


    let mut linker = Linker::new(&engine);
    linker.define(&mut store, "env", "print", print)?;
    linker.module(&mut store, "", &module)?;
    linker
        .get_default(&mut store, "")?
        .typed::<(), ()>(&store)?
        .call(&mut store, ())?;

    Ok(())
}
