const fs = require("fs")
const path = require("path")

const candidateRoots = [
  path.join(__dirname, "../../apps/gamend_web/assets/vendor"),
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
