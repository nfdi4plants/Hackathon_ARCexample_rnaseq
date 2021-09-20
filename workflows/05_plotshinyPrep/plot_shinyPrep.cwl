#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: rocker/tidyverse:4.1
requirements:
  - class: NetworkAccess
    networkAccess: true  
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "./lib"
        writable: true
baseCommand: Rscript
inputs:
  rScript:
    type: File
    inputBinding:
      position: 1
  kallistoResults:
    type: File
    inputBinding:
      position: 2
outputs:
  outFile:
    type: File
    outputBinding:
      glob: "*05_shinyPrep.RData"