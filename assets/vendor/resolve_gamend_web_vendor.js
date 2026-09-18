const fs = require("fs")
const path = require("path")

// Mirrors `shared_dep/2` in mix.exs: the sibling checkout when it is there,
// otherwise the dep under deps/. Both dep layouts are listed because the
// subtree has sat at either depth depending on the Mix version.
//
// The sibling directory must be named after the repo (`gamend`). A checkout
// under any other name simply is not found here, and the dep is used instead
// — which is the same thing a fresh clone does.
const candidateRoots = [
  path.join(__dirname, "../../../gamend/apps/gamend_web/assets/vendor"),
  path.join(__dirname, "../../deps/gamend_web/assets/vendor"),
  path.join(__dirname, "../../deps/gamend_web/apps/gamend_web/assets/vendor")
]

module.exports = function resolveGamendWebVendor(filename) {
  for (const root of candidateRoots) {
    const candidate = path.join(root, filename)

    if (fs.existsSync(candidate)) {
      return candidate
    }
  }

  throw new Error(
    `Could not locate ${filename} in gamend_web vendor assets. Tried: ${candidateRoots.join(", ")}`
  )
}
