import path from 'path'

// Different doc paths
const baseDir = path.join(__dirname, '..')
const paths = [
    path.join(baseDir, 'UE4CppAPI', 'docs.unrealengine.com/4.27'),
    path.join(baseDir, 'UE4BlueprintAPI', 'docs.unrealengine.com/4.27'),
    path.join(baseDir, 'UE4PythonAPI', 'docs.unrealengine.com/4.27'),
    path.join(baseDir, 'UE4SamplesAndTutorials', 'docs.unrealengine.com/4.27'),
    path.join(baseDir, 'UE4Guides', 'docs.unrealengine.com/4.27'),
    path.join(baseDir, 'UE4Root', 'docs.unrealengine.com/4.27')
]

export function getPaths() {
    return paths
}
