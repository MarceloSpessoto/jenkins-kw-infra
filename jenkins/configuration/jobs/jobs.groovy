pipelines = ["codecov", "formatter-shfmt", "integration_tests", "setup_and_doc", "shellcheck-reviewdog", "unit_tests"]
pipelines.each { pipeline ->
  create_pipeline(pipeline)
}

def create_pipeline(String name){
  multibranchPipelineJob(name){
    branchSources {
      github {
        id('1952385')
        scanCredentialsId('github-app')
        repoOwner('MarceloSpessoto')
        repository('kworkflow')
      }
    }
    factory {
      workflowBranchProjectFactory {
        scriptPath("jenkinsfiles/${name}")
      }
    }
    displayName(name)
  }
}
