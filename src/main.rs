use walkdir::WalkDir;

// This test is inspired by:
// 1. https://github.com/assambar/lsr-wasm-docker
// 2. https://natclark.com/tutorials/rust-list-all-files/

fn ls_dir(path: &String) {
    println!("Recursive list files and folder in {:#?}", path);

    for file in WalkDir::new(path).into_iter().filter_map(|file| file.ok()) {
        println!("{} in {:#?}", file.path().display(), path);
    }
    println!("Recursive list files and folder in {:#?} ... done", path);
}

fn main() {
    let mounts_dir = "/mnt";
    let rootfs_dir = "/";
    ls_dir(&mounts_dir.to_string());
    ls_dir(&rootfs_dir.to_string());
}
