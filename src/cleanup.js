import fs from 'fs'
import path from 'path'
import child_process from 'child_process'
import replaceInFile from 'replace-in-file'
import wget from 'wget-improved'

import mergedirs from 'merge-dirs'
import { getPaths } from './docPaths'

// List of known missing resources
const missingFiles = [
]

// Different doc paths
const paths = getPaths()
const rootBase = paths[paths.length - 1]
const rootENUS = path.join(rootBase, 'en-US')
const rootImages = path.join(rootBase, 'images')
const rootInclude = path.join(rootBase, 'include')

// Make sure the root dirs exist
if (!fs.existsSync(rootBase)) {
    fs.mkdirSync(rootBase, { recursive: true })
}

if (!fs.existsSync(rootENUS)) {
    fs.mkdirSync(rootENUS, { recursive: true })
}

if (!fs.existsSync(rootImages)) {
    fs.mkdirSync(rootImages, { recursive: true })
}

if (!fs.existsSync(rootInclude)) {
    fs.mkdirSync(rootInclude, { recursive: true })
}

// Merge common files from root doc folders
for (const docPath of paths) {
    if (docPath !== rootBase && fs.existsSync(docPath)) {
        // Merge then delete 'images'
        if (fs.existsSync(path.join(docPath, 'images'))) {
            mergedirs(path.join(docPath, 'images'), rootImages, 'skip')
            child_process.execSync(`rm -rf "${path.join(docPath, 'images')}"`)
        }

        // Merge then delete 'include'
        if (fs.existsSync(path.join(docPath, 'include'))) {
            mergedirs(path.join(docPath, 'include'), rootInclude, 'skip')
            child_process.execSync(`rm -rf "${path.join(docPath, 'include')}"`)
        }
    }
}

// Grab missing resources
downloadMissingFiles(missingFiles, rootBase);

// Clean up bad base URLs
const urlRegexHTML = /(http(s)?:\/\/)(docs\.unrealengine\.com)(:443)?/g
const urlRegexJSCSS = /(http(s)?:\/\/)?(docs\.unrealengine\.com)(:443)?/g
const navBarRegex = /n=host\+base/g

replace(path.join(rootENUS, 'index.html'), urlRegexHTML)
replace(path.join(rootENUS, 'navTree.html'), urlRegexHTML)

let navbarJS = path.join(rootBase, 'include', 'Javascript', 'navigationBar.js')
replace(navbarJS, navBarRegex, 'n=host+":3000"+base')

replace(getListOfFiles(path.join(rootBase, 'include', 'CSS')), urlRegexJSCSS)
replace(getListOfFiles(path.join(rootBase, 'include', 'Javascript')), urlRegexJSCSS)

function replace(file, regex, replaceWith) {
    replaceWith = replaceWith || ''
    try {
        const results = replaceInFile.sync({ files: file, from: regex, to: replaceWith })
        console.log('Replacement results:', results);
    }
    catch (error) {
        console.error('Error occurred:', error);
    }
}

function getListOfFiles (dir) {
    return fs.readdirSync(dir).map((file) => {
        return path.join(dir, file)
    })    
}

function downloadMissingFiles(files, destRoot) {
    files.forEach((fileURL) => {
        const destDir = fileURL.match(/https:\/\/docs\.unrealengine\.com:443\/(.*\/)/)[1]
        const filename = path.basename(fileURL)
        const fullDestDir = path.join(destRoot, destDir)
        if (!fs.existsSync(fullDestDir)) { fs.mkdirSync(fullDestDir, { recursive: true }) }
        downloadFile(fileURL, path.join(fullDestDir, filename))
    })
}

function downloadFile(file, destination) {
    const filename = path.basename(file)
    return new Promise((resolve, reject) => {
        let download = wget.download(file, destination);
        download.on('error', (err) => {
            reject(`Error downloading ${filename}: ${err}`)
        });
        download.on('start', function(fileSize) {
            console.log(`Starting download of ${filename}`)
        });
        download.on('end', function(output) {
            console.log(`Finished download of ${filename}`)
            resolve()
        })
    })
}
