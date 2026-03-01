#[derive(Debug, clap::Parser)]
#[command(version)]
struct Args {}

fn main() {
    let _args: Args = clap::Parser::parse();
    println!("Hello, world!");
}
