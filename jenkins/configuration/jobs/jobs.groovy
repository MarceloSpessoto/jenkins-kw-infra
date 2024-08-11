pipelines = ["codecov", "formatter-shfmt", "integration_tests", "setup_and_doc", "shellcheck-reviewdog", "unit_tests"]
pipelines.each { pipeline ->
  create_pipeline(pipeline)
}

def create_pipeline(String job_name){
  multibranchPipelineJob(job_name){
    branchSources {
      branchSource {
        source {
          github {
            id('1952385')
            credentialsId('github-app')
            repoOwner('MarceloSpessoto')
            repository('kworkflow')
            repositoryUrl('https://github.com/MarceloSpessoto/kworkflow')
            configuredByUrl(true)
            traits {
              gitHubStatusChecks {
                name(job_name)
                skipNotifications(true)
              }
              gitHubBranchDiscovery {
                strategyId(3)
              }
            }
          }
        }
      }
    }
    factory {
      workflowBranchProjectFactory {
        scriptPath("jenkinsfiles/${job_name}")
      }
    }
    displayName(job_name)
  }
}
